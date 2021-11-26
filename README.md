[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/esciencecenter-digital-skills/training-infrastructure/workflows/R-CMD-check/badge.svg)](https://github.com/esciencecenter-digital-skills/training-infrastructure/actions)

# Traininginfrastructure

## Description

Each of our workshops requires some documents to work with. 
This package automates the generation of those documents.

## Using GitHub secrets

This repository uses [GitHub Secrets](https://git-secret.io/).
In order to use it, you'll need to install it in your device.
See instructions [here](https://git-secret.io/).

### Authorizing a new user 

If you would like access to the tokens in this repo, create a gpg RSA key pair. Share the public key with the repo maintainer. They will have to reveal the secret to you and push the reencrypted files, giving you access. The tutorial on git-secret.io spells out these steps:

### Adding someone to a repository using git-secret

1. Get their gpg public-key. You won’t need their secret key.

2. Import this key into your gpg keyring (in ~/.gnupg or similar) by running `gpg --import KEY_NAME.txt`

3. Now add this person to your secrets repo by running `git secret tell persons@email.id` (this will be the email address associated with the public key)

4. The newly added user cannot yet read the encrypted files. Now, re-encrypt the files using `git secret reveal; git secret hide -d`, and then commit and push the newly encrypted files. (The -d options deletes the unencrypted file after re-encrypting it). Now the newly added user will be able to decrypt the files in the repo using git-secret reveal.

Want to contribute?
Please contact our maintainer [Lieke de Boer](https://github.com/liekelotte).
