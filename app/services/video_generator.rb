require 'open-uri'
require 'tempfile'
require 'open3'
require 'json'

class VideoGenerator
  def self.fetch_image_tempfile(url)
    file = Tempfile.new(['image', '.jpg'], binmode: true)
    URI.open(url) do |remote|
      file.write(remote.read)
    end
    file.flush
    file
  rescue StandardError => e
    Rails.logger.error("Failed to fetch image: #{e}")
    file&.close
    file&.unlink
    nil
  end

  def self.generate
    python_exec = Rails.root.join('python/venv/bin/python')
    script = Rails.root.join('python/generate_video.py')

    image_url = 'https://www.seagate.com/content/dam/seagate/migrated-assets/www-content/news/_shared/images/seagate-logo-image-center-374x328.png'
    image_file = fetch_image_tempfile(image_url)
    return unless image_file

    # output = Tempfile.new(['video', '.mp4'], binmode: true)

    final_path = Rails.root.join('public', 'output', 'generated_video.mp4').to_s

    config = {
      background_video: Rails.root.join('public/assets/background.mp4').to_s,
      background_audio: Rails.root.join('public/assets/background.mp3').to_s,
      output: final_path,
      gap: 1,
      clips: [
        {
          voice: Rails.root.join('public/assets/seagate.mp3').to_s,
          blocks: [
            { type: 'text', text: 'Hello World', "font-size": 72,
              font: Rails.root.join('public/assets/Montserrat-ExtraBold.ttf').to_s, color: 'white' },
            { type: 'image', path: image_file.path }
          ]
        }
      ]
    }

    Open3.popen3("#{python_exec} #{script}") do |stdin, stdout, stderr, wait_thr|
      stdin.write(config.to_json)
      stdin.close

      stdout.read
      stderr_output = stderr.read
      status = wait_thr.value

      image_file.close!
      image_file.unlink # Clean up image
      # output.close

      if status.success?
        Rails.logger.info("✅ Video generated successfully: #{final_path}")
      else
        Rails.logger.error("❌ Video generation failed: #{stderr_output}")
      end
    end

    # output.unlink # Optionally delete video after use
  end
end
