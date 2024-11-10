import { idniecap } from 'idniecap';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    idniecap.echo({ value: inputValue })
}
