# Disable KVM module because:
#   Stderr: VBoxManage: error: VirtualBox can't enable the AMD-V extension. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_SVM_IN_USE)
sudo rmmod kvm_amd
sudo rmmod kvm

# Start VM
sudo vagrant up --provider=virtualbox