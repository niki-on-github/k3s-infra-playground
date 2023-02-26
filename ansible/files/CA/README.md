# Private CA

This directory holds a copy of our private CA key + certificate.

## Install CA

```bash
CAROOT=$PWD mkcert -install
```

## Uninstall CA

```bash
CAROOT=$PWD mkcert -uninstall
```

## Whitelist your domain in Firefox

When you enter an local domain e.g. `home.server01.lan` Firefox start searching the domain with your default search engine. To
open the webpage in your local domain you have to use the prefix `http(s)://`. To allow access without this prefix you can add
your domain to the Firefox Whitelist:

1. `about:config`
2. Create boolean key: `browser.fixub.domainsuffixwhitelist.DOMAIN.TOPLEVEL` e.g. `browser.fixub.domainsuffixwhitelist.server01.lan` and set to
   `true`.
3. Create boolean key: `browser.fixup.dns_first_for_single_words` and set to `true`.
