# Web de MamaQuilla

Página estática: `index.html` + `config.js` + carpeta `assets/`.
Funciona igual en celular y computadora (elige sola el video: `cafe-movil.mp4` o `cafe.mp4`).

## 1. Publicar en GitHub Pages
1. Crea un repositorio nuevo (público) en github.com.
2. "uploading an existing file" → arrastra TODO lo que hay dentro de esta carpeta
   (index.html, config.js, README.md, carpeta assets y carpeta supabase).
3. Settings → Pages → Branch: main / (root) → Save.
4. En 1–2 minutos tendrás el link: https://TU-USUARIO.github.io/NOMBRE-DEL-REPO/

## 2. Activar el panel de administración (para que los cambios queden guardados)
Sin este paso el panel funciona en "modo de prueba".

1. Entra a supabase.com → New project (plan gratis) → espera que se cree.
2. SQL Editor → New query → pega `supabase/instalar.sql`.
   Antes de ejecutar, cambia el correo de la dueña en la línea marcada "<<< CAMBIAR". → Run.
3. Authentication → Users → Add user → Create new user:
   el MISMO correo y una contraseña. Marca "Auto Confirm User".
4. Authentication → Sign In / Providers → desactiva "Allow new users to sign up"
   (así nadie más puede crearse una cuenta).
5. Project Settings → API → copia "Project URL" y la clave "anon public"
   y pégalas en `config.js`. Sube ese `config.js` a GitHub (reemplazando el anterior).
6. Authentication → URL Configuration → Site URL: pon el link de GitHub Pages.

## 3. Cómo usa el panel la dueña
- Al final de la página: "Administrar" (o abrir el link con `#admin` al final).
- Entra con su correo y contraseña.
- Pestañas: Carta y precios · Fotos · Locales · Contacto.
- Todo se publica al pulsar **Guardar cambios**.

## Notas
- La primera vez, la web muestra la carta de ejemplo. Cuando la dueña guarda, se usa lo de la base de datos.
- Los videos están codificados con un cuadro clave cada 8 cuadros para que el scroll sea fluido:
  no los vuelvas a comprimir con otra configuración.
- Datos tomados de internet que hay que confirmar: direcciones de Pachacámac y Surco, horarios
  y el WhatsApp +51 947 344 217.
