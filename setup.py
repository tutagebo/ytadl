from setuptools import setup, find_packages

setup(
    name="ytadl",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "yt-dlp",
        "click",
    ],
    entry_points={
        "console_scripts": [
            "ytadl=ytadl.command:main",
        ],
    },
)
