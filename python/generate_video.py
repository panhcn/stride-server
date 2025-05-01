from moviepy import (
    VideoFileClip,
    AudioFileClip,
    TextClip,
    ImageClip,
    CompositeVideoClip,
    CompositeAudioClip,
    vfx,
    afx,
    clips_array,
)
import json
import sys


def generate_video_from_json():
    config = json.load(sys.stdin)

    background_video = VideoFileClip(config["background_video"])
    background_audio = AudioFileClip(config["background_audio"])
    output_path = config["output"]
    gap = config.get("gap", 1)

    all_clips = []
    audio_layers = []
    current_time = 2

    for section in config["clips"]:
        voice_clip = AudioFileClip(section["voice"])
        voice_duration = voice_clip.duration

        visual_blocks = []
        for block in section["blocks"]:
            if block["type"] == "text":
                txt_clip = (
                    TextClip(
                        text=block["text"],
                        font_size=block.get("font-size", 72),
                        font=block.get("font", "Arial"),
                        color=block.get("color", "white"),
                        bg_color=None,
                    ).with_fps(24)
                    # .with_duration(voice_duration)
                    # .with_start(current_time)
                )
                # txt_clip = txt_clip.with_effects([vfx.CrossFadeIn(1), vfx.CrossFadeOut(1)])
                visual_blocks.append([txt_clip])

            elif block["type"] == "image":
                img_clip = (
                    ImageClip(block["path"])
                    # .with_duration(voice_duration)
                    # .with_start(current_time)
                )
                # img_clip = (
                #            img_clip.with_effects([vfx.CrossFadeIn(1), vfx.CrossFadeOut(1)])
                #        )
                visual_blocks.append([img_clip])

        # Combine blocks into one stacked clip
        stacked = (
            clips_array(visual_blocks)
            .with_duration(voice_duration)
            .with_start(current_time)
            .with_position("center", "center")
            .with_effects([vfx.CrossFadeIn(0.2), vfx.CrossFadeOut(0.2)])
        )

        all_clips.append(stacked)
        audio_layers.append(voice_clip.with_start(current_time))

        current_time += voice_duration + gap

    total_time = current_time + 2
    # Build full composition
    background = background_video.subclipped(0, total_time).with_duration(total_time)
    overlay = CompositeVideoClip(all_clips, size=background.size).with_duration(
        total_time
    )
    final_video = CompositeVideoClip(
        [background, overlay], size=background.size
    ).with_duration(total_time)

    # Combine all audio layers including background music
    bg_music = background_audio.subclipped(0, total_time).with_volume_scaled(0.1)

    fadeIn = (
        AudioFileClip(config["background_audio"])
        .subclipped(0, 2)
        .with_volume_scaled(config.get("audio_volume", 0.9))
        .with_effects([afx.AudioFadeOut(2)])
    )
    fadeOut = (
        AudioFileClip(config["background_audio"])
        .subclipped(current_time, current_time + 2)
        .with_volume_scaled(config.get("audio_volume", 0.9))
        .with_effects([afx.AudioFadeIn(2)])
        .with_start(current_time)
    )

    audio_layers.extend([bg_music, fadeIn, fadeOut])

    final_audio = CompositeAudioClip(audio_layers).with_duration(total_time)
    final_video.audio = final_audio

    final_video.write_videofile(output_path, fps=24, audio_codec="aac")


if __name__ == "__main__":
    generate_video_from_json()
