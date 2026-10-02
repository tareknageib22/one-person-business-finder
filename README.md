# Use this script in a website

This repository's `script.js` is served directly from GitHub by jsDelivr; publishing it to npm is not required. Add this tag to the website where you want the script to run:

```html
<script src="https://cdn.jsdelivr.net/gh/tareknageib22/one-person-business-finder@main/script.js"></script>
```

The script targets `#headline-d107e476 h3`, changes its text to `HI | Tarek Here,`, and waits if that element is added after the script loads. Make sure the target selector matches the element in your website.

Push updates to the `main` branch to publish them. jsDelivr caches files, so a recently pushed update may not appear immediately; you can purge the file's cache at [jsDelivr's purge tool](https://www.jsdelivr.com/tools/purge).