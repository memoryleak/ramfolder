# RAMFolder
Create a mount point into memory via tmpfs and synchronize provided directory.

## Usage
````
Usage:
  ramfolder SOURCE TARGET [options]
  ramfolder --help | -h
  ramfolder --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --size, -s
    Size of the RAM disk in gigabytes.
    Default: 10

Arguments:
  SOURCE
    Source directory containing the files.

  TARGET
    Path where the RAM disk should be created.

Examples:
  ramfolder /var/www/magento2/ /mnt/ramdisk/

````

## Building
Requires [Bashly](https://github.com/DannyBen/bashly) to build from source.

* `bashly generate`

