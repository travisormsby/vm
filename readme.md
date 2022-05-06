The create_vm.bat script will create a new Hyper-V virtual machine based on a json-formatted configuration file you specify.

The json file should specify the following parmaters:

* name [string]: The name of the VM
* switch [string]: The name of an existing virtual networking switch the VM should use.
* startupRAM_GB [numeric]: How much memory (RAM), in GB, should be available to the machine when it first starts up
* processors [int]: The number of virtual processors the machine will have available
* vmPath [string]: The file path to the directory where the VM files will be stored. The directory will be created if it does not exist. Use doublebackslashes in the path string.
* isoPath [string]: The file path to the .iso file to use for the operating system installation
* diskSize_GB [numeric]: How much disk space, in GB, should be allotted to the VM's virtual hard drive.
* (optional) dynamicMemory [bool]: Whether the VM will use dynamic memory (true) or not (false). The default value is true.
* (optional) minMemory_GB [numeric]: If using dynamic memory, the minimum amount of memory (RAM), in GB, available to the machine. The default value is 0.5 GB.
* (optional) maxMemory_GB [numeric]: If using dynamic memory, the maximum amount of memory (RAM), in GB, available to the machine. The default value is 1024 GB.
