### How to let linux no-root user get access to pci device?
1. Find info about your device
```bash
udevadm info -a /dev/cybereye
```
2. On the basis of above data, create following udev rule
```
cat /etc/udev/rules.d/30-mydevice.rules 
KERNEL=="mydevice", SUBSYSTEM=="mydevice_sys", GROUP="mydevgroup", MODE="0664"
```
3. Create mydevgroup
```
sudo addgroup mydevgroup
```
4. Add relevent users to the group
```
sudo usermod -a -G mydevgroup myuser
```
5. Reload rules
```
sudo udevadm control --reload-rules
```
6. Reload kernel driver
