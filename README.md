# Marvel Catalog

Esta aplicación simplemente muestra una lista de personajes de Marvel y muestra sus detalles cuando el usuario pulsa sobre alguno de los personajes. Utiliza el API público que Marvel proporciona a los desarrolladores.

**Nota del autor:** 

Soy totalmente consciente de que diseño gráfico no es mi fuerte, cosa que no me preocupa mucho porque en la gran mayoría de los casos el diseño viene de un equipo de diseño o directamente del cliente.

Por eso el objetivo de este proyecto no es presentar una aplicación bonita, sino una demostración de arquitectura y buenas prácticas.

## Seguridad

Antes de compilar el proyecto es necesario hablar de seguridad. El API de marvel solo es accesible si tenemos en mano las claves pública y privada que Marvel proporciona a cada desarrollador.

La mejor manera de garantizar la seguridad de las claves es guardarlas en un servidor y acceder a través de ellas por medio de consultas al servidor.

Para simplificar el proyecto he elegido una opción menos segura: guardarlas en el fichero ./MarvelCatalog/MarvelKeys.xcconfig.

Este fichero está excluido en el .gitignore, por lo que antes de compilar el proyecto habrá que crear el fichero e incluir las claves. El fichero tiene que tener el siguiente formato:

> MARVEL_PRIVATE_API_KEY = insertar_clave_sin_comillas<br>
> MARVEL_PUBLIC_API_KEY = insertar_clave_sin_comillas

Este método asegura que las claves no se publiquen por Git, pero no es seguro porque las claves seguirá estando incluidas en las aplicaciones compiladas.

## Arquitectura

Para este proyecto he elegido como patrón de diseño MVVM. Por eso RxSwift es totalmente imprescindible en toda la aplicación.

Para la navegación he cogido prestado el componente Router de VIPER. Esto es porque el uso de Segues en iOS hace que los distintos UIViewControllers queden demasido dependientes unos de otros (tightly coupled). Los segues también representan una fuente de errores.

Para la inyección de dependencias se ha utilizado Swinject.

### Principios

Se han tenido en cuenta los principios **SOLID** a la hora organizar el código. Tomemos por ejemplo el protocolo MarvelRepo y la clase MarvelRepoImpl.

Estos separan la abstracción y la implementación concreta. Esto hace que se puedan aplicar cambios en la implementación o sustituirla enteramente por otra implementación sin afectar a ninguna de las clases que usan MarvelRepo, así cumpliendo con el **"Open–closed principle"**.

De hecho ninguna clase en toda la aplicación sabe que está utilizando MarvelRepoImpl, porque esta se inyecta por Inyección de Dependencias. Todas las clases que la usan dependen de la abstracción, y les da igual cuál de las implementaciones utiliza, cumpliendo al mismo tiempo con **"Liskov substitution principle"** y **"Dependency inversion principle"**

**"Single-responsibility principle"** se cumple naturalmente, ya que Marvel Repo solo se encarga de generar consultas que después se pueden ejecutar. Y **"The Interface segregation principle"** no llega a aplicarse porque aún no hay necesidad.

Uno de los principios que se han aplicado que no pertenecen a **SOLID** (aunque de alguna manera lo recomienda) es el principio de **"Composition over inheritance"** del libro **"Effective Java"**, aunque en algún caso concreto se ha hecho una excepción, como en el caso de los UIViewControllers, donde la herencia es un requisito.

Además he creado un SuperViewController para funcionalidades que no se pueden sacar del Controlador, ya que van ligadas al ciclo de vida de este.

## Directorios

El proyecto tiene los siguientes directorios principales:
- **di:** Contiene el código que configura la inyección de dependencias.
- **pages:** contiene los controladores para las distintas pantallas, una carpeta por pantalla, además de una carpeta "common" para el código que utilizan varias pantallas.
- **repo:** contiene el código que interactura con la API de Marvel.
- **resources:** contiene recursos que la app utiliza, como ejemplos de respuestas de la API de Marvel en formato json.
- **tools:** contiene herramientas de conveniencia. No son parte de ninguna capa ni módulo, pero hacen la vida más fácil, por ejemplo: MD5, generador de strings únicos, etc.

## Testing

El código está pensado para ser fácilmente testeable.

No todo el código es está incluido en el testing. Eso sería demasido trabajo y en muchas ocasiones absurdo. He elegido las partes más sensibles de la aplicación, las que más tienden a contener errores ocultos y he escrito tests unitarios para estos.

Para testear código con RxSwift he utilizado RxBlocking. Y para hacer test con Alamofire he utilizado WeTransfer/Mocker.