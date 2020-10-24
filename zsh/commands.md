Creating QEMU:

```sh
virt-install \
    --connect qemu:///system \
    --name windows \
    --virt-type kvm \
    --os-type windows \
    --os-variant win10 \
    --arch x86_64 \
    --ram 8192 \
    --network bridge=br0 \
    --disk path=/dev/sda,format=raw \
    --import
```
