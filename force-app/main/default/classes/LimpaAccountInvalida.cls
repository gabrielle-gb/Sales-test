public class LimpaAccountInvalida implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT Id, Name FROM Account';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scope) {
        List<Account> contasSemTarefas = new List<Account>();
        for (Account conta : scope) {
            if (contaTemTarefa(conta.Id) || contaSemOportunidades(conta.Id) || oportunidadesEmNegociacao(conta.Id)) {
                delete conta;
            }
        }
    }
    
    private Boolean contaTemTarefa(Id accountId) {
        String query = 'SELECT Id FROM Task WHERE WhatId = :accountId AND ActivityDate >= LAST_N_DAYS:60';
        List<Task> tarefas = Database.query(query);
    
        return !tarefas.isEmpty();
    }

    private Boolean contaSemOportunidades(Id accountId) {
        Date dataDeHoje = Date.today();
        Date dataDe120DiasAtras = dataDeHoje.addDays(-120);
    
        String query = 'SELECT Id FROM Opportunity WHERE AccountId = :accountId AND IsClosed = false AND CloseDate >= LAST_N_DAYS:120';
        List<Opportunity> oportunidadesGanhas = Database.query(query);
    
        return !oportunidadesGanhas.isEmpty();
    }

    private Boolean oportunidadesEmNegociacao(Id accountId) {
        String query = 'SELECT Id FROM Opportunity WHERE AccountId = :accountId AND IsClosed = false';
        List<Opportunity> oportunidadesEmNegociacao = Database.query(query);

        return oportunidadesEmNegociacao.isEmpty();
    }

    public void finish(Database.BatchableContext context) {
        System.debug('O processamento do lote foi concluído.');
    }
}