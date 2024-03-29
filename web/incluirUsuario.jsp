<%@page import="modelos.Acesso"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Cadastrar Usuario</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body onload="validaStatus()" style="max-width: 100%; overflow: hidden; background-color: #a1c2de">

        <%
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sess�o 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoincluirusuario() == true) {

            } else {
                if (tipo == "u") {
                    response.sendRedirect("verificaCadastraCliente.jsp?status=0");
                } else {
                      response.sendRedirect("menuPrincipal.jsp?status=1");
                }
            }

            switch (tipo) {
                  case "a": %><script src="scripts/navbarGerente.js"></script><%
                                      break;
                                    case "f": %><script src="scripts/navbarFuncionario.js"></script><%
                                      break;
                                  case "u": %><script src="scripts/navbarTotem.js"></script><%
                                          break;
                                      default:
                                          break;
                                  }

                                  String vstatus = request.getParameter("status");
            %>

        <!-- classe container para separar em grid -->
        <div class="container">
            <input type="text" name="status" id="status" value="<%out.write(vstatus);%>" readonly="true" hidden>
            <!-- classe formata pagina em 3 colunas horizontais -->
            <div class="row">
                <div class="col">
                    <!-- classe grid 2 de 3 -->
                </div>
                <!-- classe grid 2 de 3 -->
                <div class="col">

                    <form id="form" action="receberDadosUsuario.jsp"  method="POST">

                        <!--  campo para inserir usuario -->
                        <div class="form-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" name="usuario" id="usuario" class="form-control rounded-pill" required placeholder="Informe um apelido para usuario">
                        </div>
                        <!--  campo para inserir cpf -->
                        <div class="form-group">
                            <label for="cpf">CPF</label>
                            <input type="text"  name="cpf" id="cpf" class="form-control rounded-pill" maxlength="11" onkeyup="botaoEnviar()" onkeypress="return onlyNumberKey(event)" required placeholder="Informe o seu cpf">
                        </div>
                        <!-- campo para inserir senha -->
                        <div class="form-group">
                            <label for="senha">Senha</label>
                            <input type="password"  name="senha" id="senha" class="form-control rounded-pill" maxlength="20"  required placeholder="Informe a sua senha">
                        </div>

                        <button id="botaoEnviar" name="botaoEnviar" type="submit"  class="btn btn-primary rounded-pill">Cadastrar Usuario</button>

                        <!-- script para validar o campo nome , permitindo apenas caracteres normais e acentuacao -->
                        <script>
                            $('input[name=nome]').on('input', function () {
                                $(this).val($(this).val().replace(/[^a-zA-Z�-��-�_ ]/gi, ''));
                            });
                        </script>

                        <!-- script que impede o usuario digitar letra ou caracter nos campos que � solicitado numero -->
                        <script>

                            function onlyNumberKey(evt) {

                                // Only ASCII character in that range allowed
                                var ASCIICode = (evt.which) ? evt.which : evt.keyCode
                                if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                                    return false;
                                return true;
                            }
                        </script>

                    </form>
                </div>

                <div class="col">
                    <!-- classe grid 3 de 3 -->
                </div>

            </div>
        </div>




        <script>
            //FUN��O PARA VALIDACAO ADICIONAL DE CAMPOS DE CADASTRO E FAZER SUBMIT
            $(document).ready(function () {
                // desativa o botao submit do form 
                $(':input[name=botaoEnviar]').prop('disabled', true);
                // toda vez que apertar alguma tecla, dentro de um tipo texto
                $('input[type="text"]').keyup(function () {
                    //verifica tamanho do campoNome e campoCpf 
                    var campoUsuario = $('input[name=usuario]').val().length;
                    var campoCpf = $('input[name=cpf]').val().length;
                    if ((campoUsuario !== 0 && campoCpf === 11)) {
                        // desabilita (continua desabilitado) 
                        $(':input[name=botaoEnviar]').prop('disabled', false);
                    } else {
                        // habilita 
                        $(':input[name=botaoEnviar]').prop('disabled', true);
                    }
                });
            });

            function validaStatus() {
                var status = $('input[name=status]').val();
                switch (status) {
                    case "1":
                        alert("Este usuario j� possui cadastro!");
                        break;
                    case "2":
                        alert("Usuario cadastrado com sucesso!");
                        break;
                    case "3":
                        alert("Ocorreu um problema ao realizar o cadastro \n entre em contato com administra��o local!");
                        break;
                    case "4":
                        alert("Este CPF n�o foi cadastrado em Cliente! \n Realize cadastro de Cliente Primeiro!");
                        break;    
                    case "0":
                        break;
                    default:

                        break;
                }
            }
        </script>   

        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
