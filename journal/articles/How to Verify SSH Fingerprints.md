# How to Verify SSH Fingerprints

There various ways to verify SSH fingerprints. Here we outline three ways, of varying degree of security and convenience

## Most secure method

The most secure way to verify SSH finger prints is to physically access the server and run

```shell
ssh-keygen -lf KEY_FILE
```

where `KEY_FILE` is the file path to the key file. That commands output the fingerprint which can then be compared character-by-character. Another way is to have a trusted custodian copy the private and public keys from the server to the client (e.g., via thumbdrive).

## Easiest method

This method is based on the [tutorial](https://www.youtube.com/watch?v=794sn9nllSM) by YouTube user [@howtopi9941](https://www.youtube.com/@howtopi9941). In that guide the solution in macOS is as simple as 

```shell
ssh-keyscan -t KEY_TYPE HOST | ssh-keygen -lf -
```

where `KEY_TYPE` is the key type (e.g., `RSA`, `ED25519`) and `HOST` is the host you're trying to SSH into (e.g., `192.168.1.1` or `somesite.com`). Although easy, this method is [theoretically unsafe](https://security.stackexchange.com/a/251498/352772) because it is vulnerable to a man-in-the-middle attack. That risk is so low, however, that it is granted the safety moniker of Trust on first Use (TOFU).

## A theoretical optimum

A theoretical optimum is having the server host the keys on a password-protected website. Websites, however, are [also vulnerable](https://www.ibm.com/think/topics/man-in-the-middle) to Man-in-the-Middle attacks.

## References

 - https://www.youtube.com/watch?v=794sn9nllSM. Author: https://www.youtube.com/@howtopi9941
