# GitHub Action to Purge Cloudflare Cache  🗑️ 

A composite action that calls the Cloudflare API with `curl` and `jq`. The step fails when Cloudflare reports an error.

## Usage

All sensitive variables should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) in the action's configuration.

### Purge everything

```yaml
    - name: Purge cache
      uses: mailerlite/purge-cf-cache-action@v1
      with:
        cf_token: ${{ secrets.CF_TOKEN }}
        cf_zone_name: ${{ secrets.CF_ZONE_NAME }}
```

### Purge by host, URL or prefix

Pass one comma-separated list. If more than one is set, hosts win over URLs, and URLs over prefixes.

```yaml
        cf_purge_hosts: "mailerlite.com,foo.mailerlite.com"
        cf_purge_urls: "https://mailerlite.com/styles.css,https://mailerlite.com/app.js"
        cf_purge_prefixes: "mailerlite.com/static/"
```

### Invalidate instead of purge

[Invalidation](https://developers.cloudflare.com/cache/guides/invalidate-cache/) marks content stale instead of deleting it. Cloudflare revalidates it with the origin on the next request, and keeps serving the stale copy if the origin errors. With `stale-while-revalidate` on the cached response, visitors get the stale copy while it revalidates instead of waiting. It takes the same selectors, token permission and rate limits as purge.

```yaml
        cf_mode: invalidate
```
