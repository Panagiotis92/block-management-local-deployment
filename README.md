# Block Management REST API

This is a REST API for managing blocks.

An Admin user can create User, Person, Block, Flat, Manager Period.

A Manager user can create expenses, generate report and view information about his/hers Periods.

A Viewer user of a Manager Period can view information about it and is deleted when the Manager Period ends.

---

##### Run the app
1) Clone this repository  
2) Download and install docker 
3) Open terminal, cd to this folder and run:

```bash
docker compose -f block_management_compose.yml --env-file envs/env.user up -d
```

---

##### Access the REST API through Swagger UI
1) Go to [http://localhost:8080/block-management/swagger-ui/index.html](http://localhost:8080/block-management/swagger-ui/index.html)  
2) Execute **"POST credentials"** with credentials `panos-12345` (ADMIN) and copy the response (the jwt)  
3) Go to top of the page, click on **"Authorize"** and paste there the jwt  

---
 
* Connect to **postgres** database at **localhost** with password `postgres-12345`  
* To shutdown the app cd to this folder and run:

```bash
docker compose -f block_management_compose.yml down
```
