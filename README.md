# idniecap

Librería para el uso del DNIe en ionic. Disponible para android e iOS.

## Install

```bash
npm install idniecap
npx cap sync
```

## API

<docgen-index>

* [`configure(...)`](#configure)
* [`getMRZKey(...)`](#getmrzkey)
* [`readPassport(...)`](#readpassport)
* [`signTextDNIe(...)`](#signtextdnie)
* [`signDocumentDNIe(...)`](#signdocumentdnie)
* [`signHashDNIe(...)`](#signhashdnie)
* [`isNFCEnable()`](#isnfcenable)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### configure(...)

```typescript
configure(options: { apiKey: string; }) => Promise<EstadoLicencia>
```

Método utilizado para configurar el plugin.

| Param         | Type                             | Description                                                                                                                                            |
| ------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`options`** | <code>{ apiKey: string; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: apiKey (código de licencia generado que permite el uso del plugin) |

**Returns:** <code>Promise&lt;<a href="#estadolicencia">EstadoLicencia</a>&gt;</code>

--------------------


### getMRZKey(...)

```typescript
getMRZKey(options: { passportNumber: String; dateOfBirth: String; dateOfExpiry: String; }) => Promise<MRZKey>
```

Genera el código mrz en función de los parámetros introducidos

| Param         | Type                                                                                                                                                  | Description                                                                                                                                                                                                                                                                            |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ passportNumber: <a href="#string">String</a>; dateOfBirth: <a href="#string">String</a>; dateOfExpiry: <a href="#string">String</a>; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: passportNumber (número de pasaporte o numero de soporte en el caso del DNIe), dateOfBirth (fecha de nacimiento en formato yymmdd), dateOfExpiry (fecha de validez del documento en formato yymmdd) |

**Returns:** <code>Promise&lt;<a href="#mrzkey">MRZKey</a>&gt;</code>

--------------------


### readPassport(...)

```typescript
readPassport(options: { accessKey: String; paceKeyReference: number; tags: String[]; }) => Promise<RespuestaReadPassport>
```

Lee el eID utilizando la conexión NFC.

| Param         | Type                                                                                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ accessKey: <a href="#string">String</a>; paceKeyReference: number; tags: String[]; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: accessKey (Indica el can o mrz utilizado para establecer la comunicación), paceKeyReference (indica el tipo de clave usada en la conexión, se puede utilizar CAN o MRZ), tags (indica los dataGroups a leer del documento. [] para leer todos. En android si no se especifica DG2 no se recupera la foto y si no se especifica DG7 no se recupera la firma, el resto de DGs se recuperan siempre) |

**Returns:** <code>Promise&lt;<a href="#respuestareadpassport">RespuestaReadPassport</a>&gt;</code>

--------------------


### signTextDNIe(...)

```typescript
signTextDNIe(options: { accessKey: String; pin: String; datosFirma: String; certToUse: String; }) => Promise<RespuestaFirma>
```

Firma un texto con el certificado del DNIe pasado como parámetro.

| Param         | Type                                                                                                                                                                            | Description                                                                                                                                                                                                                                                                                             |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ accessKey: <a href="#string">String</a>; pin: <a href="#string">String</a>; datosFirma: <a href="#string">String</a>; certToUse: <a href="#string">String</a>; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), datosFirma (texto a firmar), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates) |

**Returns:** <code>Promise&lt;<a href="#respuestafirma">RespuestaFirma</a>&gt;</code>

--------------------


### signDocumentDNIe(...)

```typescript
signDocumentDNIe(options: { accessKey: String; pin: String; document: String; certToUse: String; }) => Promise<RespuestaFirma>
```

Firma el hash de un documento pasado como parámetro con el certificado del DNIe pasado como parámetro.

| Param         | Type                                                                                                                                                                          | Description                                                                                                                                                                                                                                                                                                       |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ accessKey: <a href="#string">String</a>; pin: <a href="#string">String</a>; document: <a href="#string">String</a>; certToUse: <a href="#string">String</a>; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), document (url del documento a firmar), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates) |

**Returns:** <code>Promise&lt;<a href="#respuestafirma">RespuestaFirma</a>&gt;</code>

--------------------


### signHashDNIe(...)

```typescript
signHashDNIe(options: { accessKey: String; pin: String; hash: Array<Number>; digest: number; certToUse: String; }) => Promise<RespuestaFirma>
```

Firma el hash pasado como parámetro con el certificado del DNIe pasado como parámetro.

| Param         | Type                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ accessKey: <a href="#string">String</a>; pin: <a href="#string">String</a>; hash: Number[]; digest: number; certToUse: <a href="#string">String</a>; }</code> | - <a href="#array">Array</a> que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), hash (hash a firmar), digest (digest del algoritmo utilizado para generar el hash. Se indica uno de los valores del tipo DigestType), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates) |

**Returns:** <code>Promise&lt;<a href="#respuestafirma">RespuestaFirma</a>&gt;</code>

--------------------


### isNFCEnable()

```typescript
isNFCEnable() => Promise<RespuestaNFC>
```

Indica si el dispositivo móvil dispone de la tecnología NFC y si esta opción está activada.

**Returns:** <code>Promise&lt;<a href="#respuestanfc">RespuestaNFC</a>&gt;</code>

--------------------


### Interfaces


#### EstadoLicencia

| Prop                          | Type                                        |
| ----------------------------- | ------------------------------------------- |
| **`descripcion`**             | <code><a href="#string">String</a></code>   |
| **`APIKeyValida`**            | <code><a href="#boolean">Boolean</a></code> |
| **`lecturaDGHabilitada`**     | <code><a href="#boolean">Boolean</a></code> |
| **`autenticacionHabilitada`** | <code><a href="#boolean">Boolean</a></code> |
| **`firmaHabilitada`**         | <code><a href="#boolean">Boolean</a></code> |


#### String

Allows manipulation and formatting of text strings and determination and location of substrings within strings.

| Prop         | Type                | Description                                                  |
| ------------ | ------------------- | ------------------------------------------------------------ |
| **`length`** | <code>number</code> | Returns the length of a <a href="#string">String</a> object. |

| Method                | Signature                                                                                                                      | Description                                                                                                                                   |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **toString**          | () =&gt; string                                                                                                                | Returns a string representation of a string.                                                                                                  |
| **charAt**            | (pos: number) =&gt; string                                                                                                     | Returns the character at the specified index.                                                                                                 |
| **charCodeAt**        | (index: number) =&gt; number                                                                                                   | Returns the Unicode value of the character at the specified location.                                                                         |
| **concat**            | (...strings: string[]) =&gt; string                                                                                            | Returns a string that contains the concatenation of two or more strings.                                                                      |
| **indexOf**           | (searchString: string, position?: number \| undefined) =&gt; number                                                            | Returns the position of the first occurrence of a substring.                                                                                  |
| **lastIndexOf**       | (searchString: string, position?: number \| undefined) =&gt; number                                                            | Returns the last occurrence of a substring in the string.                                                                                     |
| **localeCompare**     | (that: string) =&gt; number                                                                                                    | Determines whether two strings are equivalent in the current locale.                                                                          |
| **match**             | (regexp: string \| <a href="#regexp">RegExp</a>) =&gt; <a href="#regexpmatcharray">RegExpMatchArray</a> \| null                | Matches a string with a regular expression, and returns an array containing the results of that search.                                       |
| **replace**           | (searchValue: string \| <a href="#regexp">RegExp</a>, replaceValue: string) =&gt; string                                       | Replaces text in a string, using a regular expression or search string.                                                                       |
| **replace**           | (searchValue: string \| <a href="#regexp">RegExp</a>, replacer: (substring: string, ...args: any[]) =&gt; string) =&gt; string | Replaces text in a string, using a regular expression or search string.                                                                       |
| **search**            | (regexp: string \| <a href="#regexp">RegExp</a>) =&gt; number                                                                  | Finds the first substring match in a regular expression search.                                                                               |
| **slice**             | (start?: number \| undefined, end?: number \| undefined) =&gt; string                                                          | Returns a section of a string.                                                                                                                |
| **split**             | (separator: string \| <a href="#regexp">RegExp</a>, limit?: number \| undefined) =&gt; string[]                                | Split a string into substrings using the specified separator and return them as an array.                                                     |
| **substring**         | (start: number, end?: number \| undefined) =&gt; string                                                                        | Returns the substring at the specified location within a <a href="#string">String</a> object.                                                 |
| **toLowerCase**       | () =&gt; string                                                                                                                | Converts all the alphabetic characters in a string to lowercase.                                                                              |
| **toLocaleLowerCase** | (locales?: string \| string[] \| undefined) =&gt; string                                                                       | Converts all alphabetic characters to lowercase, taking into account the host environment's current locale.                                   |
| **toUpperCase**       | () =&gt; string                                                                                                                | Converts all the alphabetic characters in a string to uppercase.                                                                              |
| **toLocaleUpperCase** | (locales?: string \| string[] \| undefined) =&gt; string                                                                       | Returns a string where all alphabetic characters have been converted to uppercase, taking into account the host environment's current locale. |
| **trim**              | () =&gt; string                                                                                                                | Removes the leading and trailing white space and line terminator characters from a string.                                                    |
| **substr**            | (from: number, length?: number \| undefined) =&gt; string                                                                      | Gets a substring beginning at the specified location and having the specified length.                                                         |
| **valueOf**           | () =&gt; string                                                                                                                | Returns the primitive value of the specified object.                                                                                          |


#### RegExpMatchArray

| Prop        | Type                |
| ----------- | ------------------- |
| **`index`** | <code>number</code> |
| **`input`** | <code>string</code> |


#### RegExp

| Prop             | Type                 | Description                                                                                                                                                          |
| ---------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`source`**     | <code>string</code>  | Returns a copy of the text of the regular expression pattern. Read-only. The regExp argument is a Regular expression object. It can be a variable name or a literal. |
| **`global`**     | <code>boolean</code> | Returns a <a href="#boolean">Boolean</a> value indicating the state of the global flag (g) used with a regular expression. Default is false. Read-only.              |
| **`ignoreCase`** | <code>boolean</code> | Returns a <a href="#boolean">Boolean</a> value indicating the state of the ignoreCase flag (i) used with a regular expression. Default is false. Read-only.          |
| **`multiline`**  | <code>boolean</code> | Returns a <a href="#boolean">Boolean</a> value indicating the state of the multiline flag (m) used with a regular expression. Default is false. Read-only.           |
| **`lastIndex`**  | <code>number</code>  |                                                                                                                                                                      |

| Method      | Signature                                                                     | Description                                                                                                                   |
| ----------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **exec**    | (string: string) =&gt; <a href="#regexpexecarray">RegExpExecArray</a> \| null | Executes a search on a string using a regular expression pattern, and returns an array containing the results of that search. |
| **test**    | (string: string) =&gt; boolean                                                | Returns a <a href="#boolean">Boolean</a> value that indicates whether or not a pattern exists in a searched string.           |
| **compile** | () =&gt; this                                                                 |                                                                                                                               |


#### RegExpExecArray

| Prop        | Type                |
| ----------- | ------------------- |
| **`index`** | <code>number</code> |
| **`input`** | <code>string</code> |


#### Boolean

| Method      | Signature        | Description                                          |
| ----------- | ---------------- | ---------------------------------------------------- |
| **valueOf** | () =&gt; boolean | Returns the primitive value of the specified object. |


#### MRZKey

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`mrzKey`** | <code><a href="#string">String</a></code> |


#### RespuestaReadPassport

| Prop            | Type                                            |
| --------------- | ----------------------------------------------- |
| **`datosDNIe`** | <code><a href="#datosdnie">DatosDNIe</a></code> |
| **`error`**     | <code><a href="#string">String</a></code>       |


#### DatosDNIe

| Prop                           | Type                                                          |
| ------------------------------ | ------------------------------------------------------------- |
| **`nif`**                      | <code><a href="#string">String</a></code>                     |
| **`nombreCompleto`**           | <code><a href="#string">String</a></code>                     |
| **`nombre`**                   | <code><a href="#string">String</a></code>                     |
| **`apellido1`**                | <code><a href="#string">String</a></code>                     |
| **`apellido2`**                | <code><a href="#string">String</a></code>                     |
| **`firma`**                    | <code><a href="#string">String</a></code>                     |
| **`imagen`**                   | <code><a href="#string">String</a></code>                     |
| **`fechaNacimiento`**          | <code><a href="#string">String</a></code>                     |
| **`provinciaNacimiento`**      | <code><a href="#string">String</a></code>                     |
| **`municipioNacimiento`**      | <code><a href="#string">String</a></code>                     |
| **`nombrePadre`**              | <code><a href="#string">String</a></code>                     |
| **`nombreMadre`**              | <code><a href="#string">String</a></code>                     |
| **`fechaValidez`**             | <code><a href="#string">String</a></code>                     |
| **`emisor`**                   | <code><a href="#string">String</a></code>                     |
| **`nacionalidad`**             | <code><a href="#string">String</a></code>                     |
| **`sexo`**                     | <code><a href="#string">String</a></code>                     |
| **`direccion`**                | <code><a href="#string">String</a></code>                     |
| **`provinciaActual`**          | <code><a href="#string">String</a></code>                     |
| **`municipioActual`**          | <code><a href="#string">String</a></code>                     |
| **`numSoporte`**               | <code><a href="#string">String</a></code>                     |
| **`certificadoAutenticacion`** | <code><a href="#datoscertificado">DatosCertificado</a></code> |
| **`certificadoFirma`**         | <code><a href="#datoscertificado">DatosCertificado</a></code> |
| **`certificadoCA`**            | <code><a href="#datoscertificado">DatosCertificado</a></code> |
| **`integridadDocumento`**      | <code><a href="#boolean">Boolean</a></code>                   |
| **`pemCertificadoFirmaSOD`**   | <code><a href="#string">String</a></code>                     |
| **`datosICAO`**                | <code><a href="#datosicao">DatosICAO</a></code>               |
| **`can`**                      | <code><a href="#string">String</a></code>                     |
| **`erroresVerificacion`**      | <code>[String]</code>                                         |


#### DatosCertificado

| Prop                         | Type                                      |
| ---------------------------- | ----------------------------------------- |
| **`nif`**                    | <code><a href="#string">String</a></code> |
| **`nombre`**                 | <code><a href="#string">String</a></code> |
| **`apellidos`**              | <code><a href="#string">String</a></code> |
| **`fechaNacimiento`**        | <code><a href="#string">String</a></code> |
| **`tipo`**                   | <code><a href="#string">String</a></code> |
| **`nifRepresentante`**       | <code><a href="#string">String</a></code> |
| **`nombreRepresentante`**    | <code><a href="#string">String</a></code> |
| **`apellidosRepresentante`** | <code><a href="#string">String</a></code> |
| **`fechaInicioValidez`**     | <code><a href="#string">String</a></code> |
| **`fechaFinValidez`**        | <code><a href="#string">String</a></code> |
| **`estado`**                 | <code><a href="#number">Number</a></code> |
| **`email`**                  | <code><a href="#string">String</a></code> |


#### Number

An object that represents a number of any kind. All JavaScript numbers are 64-bit floating-point numbers.

| Method            | Signature                                           | Description                                                                                                                       |
| ----------------- | --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **toString**      | (radix?: number \| undefined) =&gt; string          | Returns a string representation of an object.                                                                                     |
| **toFixed**       | (fractionDigits?: number \| undefined) =&gt; string | Returns a string representing a number in fixed-point notation.                                                                   |
| **toExponential** | (fractionDigits?: number \| undefined) =&gt; string | Returns a string containing a number represented in exponential notation.                                                         |
| **toPrecision**   | (precision?: number \| undefined) =&gt; string      | Returns a string containing a number represented either in exponential or fixed-point notation with a specified number of digits. |
| **valueOf**       | () =&gt; number                                     | Returns the primitive value of the specified object.                                                                              |


#### DatosICAO

| Prop       | Type                                      |
| ---------- | ----------------------------------------- |
| **`DG1`**  | <code><a href="#string">String</a></code> |
| **`DG2`**  | <code><a href="#string">String</a></code> |
| **`DG13`** | <code><a href="#string">String</a></code> |
| **`SOD`**  | <code><a href="#string">String</a></code> |


#### RespuestaFirma

| Prop        | Type                                      |
| ----------- | ----------------------------------------- |
| **`firma`** | <code><a href="#string">String</a></code> |
| **`error`** | <code><a href="#string">String</a></code> |


#### Array

| Prop         | Type                | Description                                                                                            |
| ------------ | ------------------- | ------------------------------------------------------------------------------------------------------ |
| **`length`** | <code>number</code> | Gets or sets the length of the array. This is a number one higher than the highest index in the array. |

| Method             | Signature                                                                                                                     | Description                                                                                                                                                                                                                                 |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **toString**       | () =&gt; string                                                                                                               | Returns a string representation of an array.                                                                                                                                                                                                |
| **toLocaleString** | () =&gt; string                                                                                                               | Returns a string representation of an array. The elements are converted to string using their toLocalString methods.                                                                                                                        |
| **pop**            | () =&gt; T \| undefined                                                                                                       | Removes the last element from an array and returns it. If the array is empty, undefined is returned and the array is not modified.                                                                                                          |
| **push**           | (...items: T[]) =&gt; number                                                                                                  | Appends new elements to the end of an array, and returns the new length of the array.                                                                                                                                                       |
| **concat**         | (...items: <a href="#concatarray">ConcatArray</a>&lt;T&gt;[]) =&gt; T[]                                                       | Combines two or more arrays. This method returns a new array without modifying any existing arrays.                                                                                                                                         |
| **concat**         | (...items: (T \| <a href="#concatarray">ConcatArray</a>&lt;T&gt;)[]) =&gt; T[]                                                | Combines two or more arrays. This method returns a new array without modifying any existing arrays.                                                                                                                                         |
| **join**           | (separator?: string \| undefined) =&gt; string                                                                                | Adds all the elements of an array into a string, separated by the specified separator string.                                                                                                                                               |
| **reverse**        | () =&gt; T[]                                                                                                                  | Reverses the elements in an array in place. This method mutates the array and returns a reference to the same array.                                                                                                                        |
| **shift**          | () =&gt; T \| undefined                                                                                                       | Removes the first element from an array and returns it. If the array is empty, undefined is returned and the array is not modified.                                                                                                         |
| **slice**          | (start?: number \| undefined, end?: number \| undefined) =&gt; T[]                                                            | Returns a copy of a section of an array. For both start and end, a negative index can be used to indicate an offset from the end of the array. For example, -2 refers to the second to last element of the array.                           |
| **sort**           | (compareFn?: ((a: T, b: T) =&gt; number) \| undefined) =&gt; this                                                             | Sorts an array in place. This method mutates the array and returns a reference to the same array.                                                                                                                                           |
| **splice**         | (start: number, deleteCount?: number \| undefined) =&gt; T[]                                                                  | Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.                                                                                                                      |
| **splice**         | (start: number, deleteCount: number, ...items: T[]) =&gt; T[]                                                                 | Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.                                                                                                                      |
| **unshift**        | (...items: T[]) =&gt; number                                                                                                  | Inserts new elements at the start of an array, and returns the new length of the array.                                                                                                                                                     |
| **indexOf**        | (searchElement: T, fromIndex?: number \| undefined) =&gt; number                                                              | Returns the index of the first occurrence of a value in an array, or -1 if it is not present.                                                                                                                                               |
| **lastIndexOf**    | (searchElement: T, fromIndex?: number \| undefined) =&gt; number                                                              | Returns the index of the last occurrence of a specified value in an array, or -1 if it is not present.                                                                                                                                      |
| **every**          | &lt;S extends T&gt;(predicate: (value: T, index: number, array: T[]) =&gt; value is S, thisArg?: any) =&gt; this is S[]       | Determines whether all the members of an array satisfy the specified test.                                                                                                                                                                  |
| **every**          | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; boolean                                 | Determines whether all the members of an array satisfy the specified test.                                                                                                                                                                  |
| **some**           | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; boolean                                 | Determines whether the specified callback function returns true for any element of an array.                                                                                                                                                |
| **forEach**        | (callbackfn: (value: T, index: number, array: T[]) =&gt; void, thisArg?: any) =&gt; void                                      | Performs the specified action for each element in an array.                                                                                                                                                                                 |
| **map**            | &lt;U&gt;(callbackfn: (value: T, index: number, array: T[]) =&gt; U, thisArg?: any) =&gt; U[]                                 | Calls a defined callback function on each element of an array, and returns an array that contains the results.                                                                                                                              |
| **filter**         | &lt;S extends T&gt;(predicate: (value: T, index: number, array: T[]) =&gt; value is S, thisArg?: any) =&gt; S[]               | Returns the elements of an array that meet the condition specified in a callback function.                                                                                                                                                  |
| **filter**         | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; T[]                                     | Returns the elements of an array that meet the condition specified in a callback function.                                                                                                                                                  |
| **reduce**         | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T) =&gt; T                           | Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.                      |
| **reduce**         | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T, initialValue: T) =&gt; T          |                                                                                                                                                                                                                                             |
| **reduce**         | &lt;U&gt;(callbackfn: (previousValue: U, currentValue: T, currentIndex: number, array: T[]) =&gt; U, initialValue: U) =&gt; U | Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.                      |
| **reduceRight**    | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T) =&gt; T                           | Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function. |
| **reduceRight**    | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T, initialValue: T) =&gt; T          |                                                                                                                                                                                                                                             |
| **reduceRight**    | &lt;U&gt;(callbackfn: (previousValue: U, currentValue: T, currentIndex: number, array: T[]) =&gt; U, initialValue: U) =&gt; U | Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function. |


#### ConcatArray

| Prop         | Type                |
| ------------ | ------------------- |
| **`length`** | <code>number</code> |

| Method    | Signature                                                          |
| --------- | ------------------------------------------------------------------ |
| **join**  | (separator?: string \| undefined) =&gt; string                     |
| **slice** | (start?: number \| undefined, end?: number \| undefined) =&gt; T[] |


#### RespuestaNFC

| Prop             | Type                                        |
| ---------------- | ------------------------------------------- |
| **`disponible`** | <code><a href="#boolean">Boolean</a></code> |
| **`activo`**     | <code><a href="#boolean">Boolean</a></code> |

</docgen-api>
