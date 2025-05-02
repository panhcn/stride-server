# frozen_string_literal: true

# app/controllers/videos_controller.rb
class VideosController < ApplicationController
  def generate
    path = ::VideoGenerator.generate

    if path && File.exist?(path)
      send_file path, type: 'video/mp4', disposition: 'attachment', filename: 'generated.mp4'
    else
      render plain: 'Video generation failed', status: :internal_server_error
    end
  end
end
