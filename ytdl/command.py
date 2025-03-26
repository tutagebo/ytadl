import click
from .downloader import download_audio

@click.command()
@click.argument("url")
@click.argument("output_dir", type=click.Path(exists=True))
@click.option("--ffmpeg", "ffmpeg_location", type=click.Path(), help="select ffmpeg's path")
def main(url, output_dir, ffmpeg_location):
    download_audio(url, output_dir, ffmpeg_location)

if __name__ == "__main__":
    main()
