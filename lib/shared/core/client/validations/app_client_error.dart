enum AppClientError {
  internalServerError,
  notFound,
  requestError,
}

extension AppClientErrorMessage on AppClientError {
  static const messageMap = {
    AppClientError.internalServerError:
        'Ocorreu um erro interno no servidor, tente novamente mais tade.',
    AppClientError.notFound:
        'O servidor não pode encontrar os dados solicitados.',
    AppClientError.requestError:
        'Não foi possível fazer a consulta online. Verifique seu acesso a internet.',
  };

  String get message {
    return messageMap[this].toString();
  }
}
