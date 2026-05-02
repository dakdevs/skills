# Factor VII — Port Binding

> **Rule:** Export services via port binding. Be self-contained.

## The principle

The app **embeds its own server** (Tornado, Jetty, Thin, Express, ASP.NET Kestrel, Go's `net/http`) and **listens on a port**. It does not require being deployed inside an external server container (Apache, Tomcat, IIS, mod_php).

The app *is* a network service. Any other process — a load balancer, another app — can consume it by URL.

## Why this exists

Self-containment makes the app portable. The same artifact runs on a developer's laptop with `./app` and in production behind any load balancer or routing layer. There is no "deploy a WAR into Tomcat" ceremony. The app is the executable; the executable opens a port.

This factor is also what makes one app a **backing service for another app** trivial — give the second app a URL via config (f03), done.

## Compliance

- **Webserver is a library**, not external infra. Bundled via dependency manager (f02).
- **Listen on a port supplied by config**, conventionally `PORT` env var.
- **HTTP is just one example.** Same principle applies to gRPC, MQTT, WebSocket, custom TCP — bind a port, accept connections.
- **External routing is the platform's job.** TLS termination, load balancing, hostname routing live outside the app, in the platform's edge layer.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| App is a `.war` file deployed into Tomcat we manage | App is not self-contained; can't run without the container |
| App requires Apache + mod_php + a specific php.ini | Not portable; "deploy" means configuring Apache |
| Hard-coded port number in source | Should come from `PORT` env var |
| App can't be invoked except via `apache2ctl` | Not self-contained |
| TLS cert paths hard-coded in app, app does TLS itself | Usually fine; just be aware the platform's edge can do this and is more flexible |

## Modern interpretation

- **Containers are the primary embodiment.** A container exposes ports; orchestrators route to them. Fully f07-compliant.
- **Lambda / Cloud Run / serverless:** No port bound by the user; the runtime invokes a function. The *spirit* of f07 — self-contained, not requiring an external server container — is still satisfied. The runtime is the equivalent of the platform routing layer.
- **Sidecars (Envoy, linkerd-proxy):** Sidecar binds the public port; app binds an internal port; sidecar proxies. The app is still self-contained at its own port. f07-compliant.
- **Reverse proxies (Nginx, Cloudflare, ALB):** External routing is *expected* in this model. Nginx is not the "container"; it's the routing layer. f07 is about the app not *requiring* one to even start.
- **Mesh networking (Istio):** Same as sidecars — fine.

## Quick check

> "Can I run this app on my laptop with `./run` (or `docker run`) and `curl http://localhost:$PORT/` works, with no other server software?"

Yes → compliant.
