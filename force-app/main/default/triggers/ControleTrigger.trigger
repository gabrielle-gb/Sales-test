trigger ControleTrigger on Account (before insert, before update) {
    String invalido = 'Número do cliente é inválido';
    boolean accountNumberValido = false;
    boolean cnpjValidado = false;
    for(Account account: Trigger.new){
        accountNumberValido = Utils.validaAccountNumber(account);
        if(accountNumberValido){
            account.addError(invalido);
        }
        if(account.type == 'Parceiro'){
           Opportunity opp = new Opportunity();
           Date dataAtual = Date.today();
           Date closeDate = dataAtual.addDays(30);
           opp.Name = account.Name + ' - opp Parceiro';
           opp.CloseDate =  closeDate;
           opp.StageName =  'Qualification';
           insert opp;
        }
        if(account.type == 'Consumidor Final'){
            Task task = new Task();
            task.Subject = 'Consumidor Final';
            task.WhatId = account.Id;
            task.Status = 'Não Iniciada';
            task.Priority = 'Normal';
            insert task;
        }
    }
    
}