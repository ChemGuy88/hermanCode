# SSH Flowchart

A simple, approachable, and-when possible-, visual description of how SSH works.

1. Your computer, the client, checks its `known_hosts` file to see if the host has been visited before.
2. The host checks if your computer's public key exists in its `authorized_keys` file.
   1. If it is not, the client is prompted for a password for authentication.
   2. If it is, the client is not prompted for a password, and authentication is scucessfull.
