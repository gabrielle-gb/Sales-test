@isTest
public class ControleTeste {
    @isTest
    static void validaAccount(){
        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Jose B', Type = 'CPF', AccountNumber = '123456'));
        accountList.add(new Account(Name='Julieta G', Type = 'Parceiro', AccountNumber = '123456'));
        accountList.add(new Account(Name='Julieta G', Type = 'Consumidor Final', AccountNumber = '123456'));
        boolean accountNumberValido = false;
        for(Account a: accountList){
            accountNumberValido = Utils.validaAccountNumber(a);
        
            accountNumberValido = Utils.validaAccountNumber(a);
            insert a;
            if(accountNumberValido){
                System.assertEquals(false, accountNumberValido, 'Número do cliente é inválido');
            }
            if(a.type == 'Parceiro'){
               Opportunity opp = new Opportunity();
               Date dataAtual = Date.today();
               Date closeDate = dataAtual.addDays(30);
               opp.Name = a.Name + ' - opp Parceiro';
               opp.CloseDate =  closeDate;
               opp.StageName =  'Qualification';
               insert opp;
            }
            if(a.type == 'Consumidor Final'){
                Task task = new Task();
                task.Subject = 'Consumidor Final';
                task.WhatId = a.Id;
                task.Status = 'Não Iniciada';
                task.Priority = 'Normal';
                insert task;
            }
        }
    }
}