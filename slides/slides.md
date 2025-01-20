---
theme: ./theme
title: Feature Flag All The Things
info: |
  Feature flags are amazing for derisking code and separating deployments from releases!
  However, ironically, for all of the enablement platform engineers do to build continuous delivery, our own infrastructure rarely gets to benefit.
  But! What if you could put Feature Flags into ArgoCD?
  What would that look like?
  How would it work?

  Join Hazel in a fast paced talk as she goes over how feature flags might work for infrastructure and how one can integrate them into ArgoCD.
  We'll demonstrate this with a proof of concept of tying together a feature flag for the frontend, backend, and infrastructure in a seamless way.
# apply unocss classes to the current slide
drawings:
  persist: false
selectable: true
mdc: true
overviewSnapshots: true
author: Hazel Weakly
themeConfig:
  primary: "hsl(var(--color-secondary))"
fonts:
  sans: "Zilla Slab"
  serif: "Italiana"
  mono: '"Victor Mono"'
  provider: none

# front matter for first slide
class: text-center
layout: intro
defaults:
  layout: default
---

# Feature Flag All The Things

---
layout: quote
---

# What are Feature Flags?

From: https://openfeature.dev/

> Feature flags are a software development technique that allows teams to enable, disable or change the behavior of certain features or code paths in a product or service, without modifying the source code.

Sounds awesome! But, let's boil that down to its essence

---
layout: intro
---

# What are Feature Flags?

Feature flags are a software development technique that allows teams to enable, disable or **change the behavior** of certain features or code paths in a **product** or service, **without modifying the source code**.

---
layout: intro
---

# What are Feature Flags?

Feature flags allow teams to change the behavior in a product, without modifying the source code.

---
layout: intro
---

# What are Feature Flags?

Feature flags allow teams to change the behavior in a product, ~~without modifying the source code~~.

---
layout: intro
---

# What are Feature Flags?

Feature flags allow team**s** to change the behavior in a product, **at runtime**

---
layout: intro
---

# Feature flags allow teams to coordinate runtime optionality

and in a distributed system, we get distributed runtime optionality

---

# Flags For Thee, Not For Me

So it turns out, well, infrastructure doesn't really have this.

(Or unit testing)

( (Or incremental reloading) )

( ( ( or basically any development convenience of the last 30 years ... ) ) )

---

# Does That Matter?

Yeah! Feature flags are awesome. But okay, we need convincing...

The most powerful thing you can use feature flags for is unify the concept of "runtime" + "configuration" across the tech stack.

> Coordination + Runtime Optionality + Distributed = Feature Flags

Kubernetes + Terraform + Infrastructure + Backend + Frontend + Business Intelligence + Test frameworks + Security + Compliance + Architecture + Marketing + Product + ...

---

# Separate Release and Deploy? Think Bigger

Sure, you can separate release and deploy, but you can _also_:

- Conditionally enable features based on the underlying infrastructure
- Change out the software at runtime, incrementally, with different architectural assumptions
- Take advantage of the best features of each platform you run on

---

# A sketch of a proof-of-concept

Apologies, but the demo broke and I ran out of time to fix it, so here's a sketch of how this was going to originally work :)

---

# ArgoCD + OpenFeature + Events = Yummy

Here's the outline:

1. Use ArgoCD's ability to generate deployment manifests utilizing a plugin / API server and watch for changes

---

# ArgoCD + OpenFeature + Events = Yummy

Here's the outline:

2. Use OpenFeature to provide a central _store_ of features and a central API to _access_ them from diffrent parts of the tech stack.
   - ArgoCD reads from this with the plugin
   - The front-end, back-end, and any other thing with an SDK reads from this with its API

---

# ArgoCD + OpenFeature + Events = Yummy

Here's the outline:

3. Combine this with propagation glue code via webhooks, rpc, events, etc to start tying together other systems into this
   - Jira labels? Feature flags? `they're_the_same_picture.jpg`
   - The alerts triggered and now on-call is paging you to flip a switch? Have the alerts trigger the switch
   - Product OKRs for A/B feature success? Sounds like a feature flag

---
layout: intro
---

# Your Turn

Coordination +  
Runtime Optionality +  
Distributed  
= Feature Flags

---
layout: intro
---

# Your Turn

Coordination _/ Cross-Functional Collaboration / Multiple Data-Sources_ +  
Runtime Optionality _/ Progressive Deploy / Derisking Change_ +  
Distributed _(across time? across space? across systems? across workloads?)_  
= Feature Flags

---

# Hazel's Ideas

Test out a new database driver, ORM, and new database, in order to swap between two different dabase engines without downtime.

---

# Hazel's Ideas

Change the architecture of the application and the codebase at the same time.
Migrate to arm64 and an api-gateway sidecar setup and see how that changes performance, adjust accordingly

---

# Hazel's Ideas

Change _assumptions_ that are deeply rooted in the company.

IP only everywhere? Swap out the code with DNS based routing... but only when you're ready.

Does your code assume reads are fast and writes rarely happen? Did that stop being true? Refactor access patterns without crying and try it out on canary audiences with ideal workloads.

---

# Hazel's Ideas

Need to change a codepath in your codebase due to a new compiler version but you need to support multiple versions still?
Feature flag the infrastructure and _detect the activated feature_ in the codebase to conditionally load certain codepaths.

(This can be useful in languages where the runtime performance behavior varies wildly based on how core libraries optimized certain things or not)

---

# Hazel's Ideas

A huge mistake of most multi cloud is trying to achieve perfect parity, so don't: lean into the feature flags!
Take advantage of the best features of each cloud or platform without blowing up the codebase or needing wrappers for everything under the sun.

---

# Hazel's Ideas

Build an API that returns a valid response that's authorized and authenticated in a very granular manner, but _also_ where the API returns content modified to be correct for the local region it's in.

(Example: a healthcare endpoint that returns only information that is legally allowed to be shared in the local jurisdiction)

---

# Hazel's Ideas

Use feature flags to create an automatic circuit breaker for all releases.
When the flag is tripped, automatically:

- open a low priority incident
- create a jira ticket for the retrospective
- notify relevant non-engineering stakeholders

---

# Hazel's Ideas

Combine feature flags with compliance and regulatory controls in order to automatically allow deployments only in authorized environments.

When a vulnerability is discovered, remediation is a simple "turn off feature flag related to that dependency"

---

# Hazel's Ideas

SPIFFE / SPIRE? Feature flags? Dependency injection? RUM?

Surprisingly similar :)

---

# Postlude

Here's where I'd put the demo repo

...

If I had one 😡

(Actually I do have one, it just doesn't work yet. I'll keep tinkering on it so feel free to keep an eye on it): <https://github.com/hazelweakly/feature-flag-all-the-things>
