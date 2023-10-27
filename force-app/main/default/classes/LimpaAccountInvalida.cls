public class LimpaAccountInvalida implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        System.debug('Este é um log de depuração.');
        String query = 'SELECT Id, Name FROM Account';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scope) {
        List<Account> contasSemTarefas = new List<Account>();
        for (Account conta : scope) {
            if (!contaTemTarefaNosUltimos1Dias(conta.Id)) {
                contasSemTarefas.add(conta);
            }
        }
    
    }
    
    private Boolean contaTemTarefaNosUltimos1Dias(Id accountId) {
        Date dataDeHoje = Date.today();
        Date dataDeOntem = dataDeHoje.addDays(-1);
    
        String query = 'SELECT Id FROM Task WHERE WhatId = :accountId AND ActivityDate >= LAST_N_DAYS:1';
        List<Task> tarefas = Database.query(query);
    
        return !tarefas.isEmpty();
    }

    public void finish(Database.BatchableContext context) {
        System.debug('O processamento do lote foi concluído.');
    }
}