# Punto Estrella
Una URL (Uniform Resource Locator) es una cadena de caracteres que identifica una dirección única en la web. Es el medio utilizado para acceder a recursos en Web, como páginas web, imágenes, videos, archivos, entre otros.

Las URLS deben cumplir un formato específico, el cual se define en la especificación RFC 3986. Este formato se compone de 3 partes: el esquema, el nombre de host y el path. Tambien el formato implica que todos los caracteres deben estar codificados en ASCII. Pero los nombres de dominiio pueden contener caracteres no ASCII, por lo que se utiliza el estándar IDN (Internationalized Domain Names) para convertirlos a ASCII. 

El metodo para esto se llama punycode.Este es un método para representar nombres de dominio Unicode (como 中文.tw) en caracteres ASCII (a-z, 0-9, etc.) que son compatibles con el sistema de nombres de dominio (DNS). Se utiliza para que los navegadores y otros programas puedan manejar nombres de dominio internacionalizados. El proceso implica convertir los caracteres Unicode en un conjunto de caracteres ASCII que se pueden usar en un nombre de dominio. De esta manera, el nombre de dominio 中文.tw se convierte en xn--fiq228c.tw. 

En resumen, los mecanismos de Punycode e IDN permiten que los nombres de dominio Unicode y caracteres especiales se conviertan en caracteres compatibles con DNS, permitiendo así que los nombres de dominio como http://中文.tw/ (xn--fiq228c.tw) y https://💩.la (xn--ls8h.la )funcionen correctamente en la web.

Estos son algunos ejemplos de como se transcriben las codificaciones de los caracteres unicode en punnycode:

| Caracter Unicode | Codificacion Punnycode |
| --- | --- |
| 中 | xn--fiq228c |
| 💩 | xn--ls8h |
| niño | xn--nio-7ma |

