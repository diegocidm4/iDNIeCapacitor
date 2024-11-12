# idniecap

Librería basada en Swift para el uso del DNIe en ionic

## Install

```bash
npm install idniecap
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`configure(...)`](#configure)
* [`readPassport(...)`](#readpassport)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### configure(...)

```typescript
configure(options: { apiKey: string; }) => Promise<EstadoLicencia>
```

| Param         | Type                             |
| ------------- | -------------------------------- |
| **`options`** | <code>{ apiKey: string; }</code> |

**Returns:** <code>Promise&lt;<a href="#estadolicencia">EstadoLicencia</a>&gt;</code>

--------------------


### readPassport(...)

```typescript
readPassport(options: { accessKey: String; paceKeyReference: number; }) => Promise<RespuestaReadPassport>
```

| Param         | Type                                                                                |
| ------------- | ----------------------------------------------------------------------------------- |
| **`options`** | <code>{ accessKey: <a href="#string">String</a>; paceKeyReference: number; }</code> |

**Returns:** <code>Promise&lt;<a href="#respuestareadpassport">RespuestaReadPassport</a>&gt;</code>

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

</docgen-api>
