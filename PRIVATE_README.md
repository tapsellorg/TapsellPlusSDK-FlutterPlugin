# Private readme file
This file is a note for contributors and not for plugin users

## GitFlow
- `master`: Stable branch. **Merge to it when code is stable**
- `develop`: Development branch. **Merge to it when code is ready**
- `release/VERSION`: Release branch. Get from `develop` and use `alpha/beta/dev` postfixes to push tags on this branch.

Flow is **`develop` -> `release/VERSION` -> `TAG` -> `master`**


## Publish guide
- CI/CD: Push a `tag` to publish a version to `pub`.  

> Note: If you push stable tag (version with no `dev`, `alpha`, `beta` nor `rc`) 
> then public source (source and example) will be pushed to github. Non-stable versions don't upload anything.

> **Failure in CI**: If CI credentials were too old and publish failed you need to update them manually.  
> 
> If you already pushed a version manually, look for `pub_credentials.json` file and paste the new content in CI env var.
> MacOS address: `/Users/username/Library/Application Support/dart`
> 
> [This](https://stackoverflow.com/a/70487480/6678991) might be helpful.
> 
> If you have not pushed a version before, push an alpha version or contact an actual admin

- Manually: Use `flutter pub publish` to publish a version to `pub`.

> **NOTE**: To be able to publish manually your email must be added to pub admin. Contact an actual admin for that.