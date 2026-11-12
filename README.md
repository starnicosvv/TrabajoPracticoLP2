# Trabajo Práctico — Laboratorio de Programación 2

[![C#](https://img.shields.io/badge/C%23-512BD4?style=flat-square&logo=dotnet&logoColor=white)](#)
[![ASP.NET WebForms](https://img.shields.io/badge/ASP.NET-WebForms-512BD4?style=flat-square&logo=dotnet&logoColor=white)](#)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)](#)
[![Visual Studio](https://img.shields.io/badge/Visual_Studio-Solution-5C2D91?style=flat-square&logo=visualstudio&logoColor=white)](#)

Aplicación académica desarrollada como trabajo práctico de **Laboratorio de Programación 2**. El sistema registra y calcula calificaciones aplicando una arquitectura en capas, con una interfaz web en **ASP.NET WebForms** y un proyecto de consola para operaciones **CRUD**.

## Arquitectura

La solución `CRUD.sln` está organizada en capas para separar la presentación, la lógica de negocio y el acceso a datos:

| Proyecto | Rol |
|---|---|
| `ProyectoC` | Presentación web (ASP.NET WebForms: `Default.aspx`, `Notas.aspx`, `About.aspx`, `Contact.aspx`) |
| `BLL` | Lógica de negocio: DTOs (`DTOCALIFICACIONES`) y fachada (`CALCULARCALIF`) |
| `BLLL` | Capa de lógica complementaria con su propio DTO y fachada |
| `CRUD` | Proyecto de consola para operaciones CRUD (`Program.cs`) |

## Funcionalidades

- Registro y cálculo de calificaciones mediante reglas de negocio centralizadas en la capa `BLL`.
- Interfaz web con páginas de inicio, notas, información y contacto.
- Separación de responsabilidades entre presentación, lógica y datos.
- Proyecto de consola para practicar operaciones CRUD.

## Requisitos

- **Visual Studio** con soporte para ASP.NET WebForms (.NET Framework).
- **.NET Framework** compatible con los proyectos de la solución.
- Windows (WebForms requiere IIS Express o IIS para ejecutarse).

## Cómo ejecutar

1. Abre `CRUD.sln` en Visual Studio.
2. Restaura los paquetes NuGet si es necesario.
3. Establece `ProyectoC` como proyecto de inicio.
4. Ejecuta con **F5** (IIS Express).

## Autor

**Adolfo Sanabria** · [GitHub](https://github.com/starnicosvv) · [LinkedIn](https://www.linkedin.com/in/nicol%C3%A1s-sanabria-141746309/)

Proyecto académico de uso educativo.
