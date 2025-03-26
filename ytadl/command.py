import click
from .downloader import download_audio, download_video

@click.command()
@click.argument("url")
@click.argument("output_dir", type=click.Path(exists=True))
@click.option("--ffmpeg", "ffmpeg_location", type=click.Path(), help="select ffmpeg's path")
@click.option('-v','--video', is_flag=True, help='youtubeの動画をダウンロードするモード')
def main(url, output_dir, ffmpeg_location, video):
    if video:
        download_video(url, output_dir, ffmpeg_location)
    else:
        download_audio(url, output_dir, ffmpeg_location)

if __name__ == "__main__":
    main()
