# Block Management

### Description

A platform for managing blocks.

#### User Roles:
* **Admin:** As an *Admin* you can create *Blocks*, *Flats*, *Tenants*, *Owners*, *Multipliers*, *Managers*, *Viewers*, *Manager Periods*

* **Manager:** As a *Manager* you can view info for the *Blocks* you manage, create *Expenses*, get pdf report and send *Expenses* to *Tenants* and *Owners* through email

* **Viewer:** *Tenants* and *Owners* of a *Block* can log in with a *Viewer* user to view *Block's* info

---

### Instructions

#### Run:
##### Prequisities: [git](https://git-scm.com/), [docker](https://www.docker.com/)

1) Clone this repository
2) Open a terminal and cd to this folder
3) Open docker and run
```bash
docker compose -f block_management_compose.yml --env-file envs/env.user up -d
```
#### Use:
1) Open a browser at [http://localhost:8100](http://localhost:8100)
2) Log in with `panos-12345` (*Admin*) to create a *Manager Period* (along with all related entities)
3) After that you can logout and log in as the *Manager* you created so you can create *Expenses*
 
#### Shutdown:
To shutdown the platform cd to this folder and run:

```bash
docker compose -f block_management_compose.yml down
```

---

### Extra

#### Access the REST API: 

1) Go to [Swagger UI](http://localhost:8080/block-management/swagger-ui/index.html)
2) Execute the service **"POST credentials"** with credentials `panos-12345` (*Admin*)
3) Copy token from response
4) Go to the top right of the page click on **"Authorize"** and paste there the token
5) Now you can access the other services (available to admin)

You can logout from **"Authorize"** and execute from step 2 with another user with a different role to access services available only to Manager and Viewer

#### Connect to the database:
* Connect to **postgres** database at **localhost** with password `postgres-12345`
