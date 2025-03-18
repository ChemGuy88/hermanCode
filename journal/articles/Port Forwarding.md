# Port Forwarding

## For SSH

These instructions assume you're using an AT&T router, specifically the BGW320 series which is common for fiber optic internet services. Other routers might have similar settings. On your BGW320 go to "Firewall" >> "NAT/Gaming" and create a custom service. Fill out the fields accordingly:

- Service Name: *SSH*
- Global Port Range: *22*, *22* if using just port 22. In other words, if you are using just one port, you can enter it in one field and the router automatically knows you just want one port. If you want a range of ports, put the lowest port on the left field and the highest port on the right field. For example, if you want the range from 1024 to 1030, you would do *1024*, *1030*.
- Base Host Port: *22* or [something appropriate](https://www.linuxquestions.org/questions/linux-newbie-8/port-range-for-ssh-4175676679/)
- Protocol: *TCP/UDP* or [something appropriate](https://www.codecademy.com/resources/blog/port-forwarding/#:~:text=%E2%80%8B%E2%80%8BPort%20forwarding%20with%20%E2%80%8BTCP%20%E2%80%8Bcompared%20to%E2%80%8B%20UDP&text=It's%20the%20one%20we%20use,be%20put%20back%20together%20reliably.)


## For hosting websites

This is a placeholder header. For reference, see [this article](https://www.codecademy.com/resources/blog/port-forwarding/#:~:text=%E2%80%8B%E2%80%8BPort%20forwarding%20with%20%E2%80%8BTCP%20%E2%80%8Bcompared%20to%E2%80%8B%20UDP&text=It's%20the%20one%20we%20use,be%20put%20back%20together%20reliably.)
