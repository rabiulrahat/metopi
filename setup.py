from setuptools import setup, find_packages

setup(
    name="metopi",
    version="1.0.0",
    description="A modern, cross-platform countdown timer",
    author="Your Name",
    packages=find_packages(),
    install_requires=[],
    entry_points={
        'console_scripts': [
            'metopi=metopi.app:main',
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
