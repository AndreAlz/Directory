# Directory
## Introduction
This app was built to control the differents *annexes* we have in a contact center, improving their **search**, **control** and **management**.
To understand how Shiny works in general, you have to understand the concept of a different paradigm, **reactive programming**.

> Reactive programming is a subset of asynchronous programming and a paradigm where the availability of new information drives the logic forward rather than having control flow driven by a thread-of-execution.
>- Jonas Bonér and Viktor Klang, [Reactive Programming vs. Reactive Systems](https://www.oreilly.com/ideas/reactive-programming-vs-reactive-systems)

The reactivity and data flow of this repository is showed in this simple map:

![Reactivity Map](https://user-images.githubusercontent.com/31576039/45839122-11f51680-bcd9-11e8-9e41-f906d103aa4f.png)

This is an example of how the Shiny app looks like in the end:

![Overview](https://user-images.githubusercontent.com/31576039/45829616-f847d500-bcc0-11e8-9883-ce55a82eb261.png)
## Libraries
I am using the following libraries in *server.R*:

Library | Usage | Documentation
------- | ----- | -------------
DBI | Connection to the DB, sending queries and catching resultant information | [DBI package R](https://www.rdocumentation.org/packages/DBI/versions/0.5-1)
RMySQL | Driver for the connection | [RMySQL package R](https://www.rdocumentation.org/packages/RMySQL/versions/0.10.15)
DT | Select row in the datatable rendered by Shiny | [DT package R](https://www.rdocumentation.org/packages/DT/versions/0.4)
data.table | Better management of the information uploaded in an Excel file | [data.table package R](https://www.rdocumentation.org/packages/data.table/versions/1.11.6)
readxl | Read and save the Excel file uploaded even though it is a 'xls' or 'xlsx' | [readxl package R](https://www.rdocumentation.org/packages/readxl/versions/1.1.0)
Stringr | Creating a query to insert all the information form the Excel(found it in [here](https://user-images.githubusercontent.com/31576039/45834019-c425e180-bccb-11e8-9321-04dc81f1d093.png)) | [Stringr package R](https://www.rdocumentation.org/packages/stringr/versions/1.3.1)
## Functions
## Server
## UI
