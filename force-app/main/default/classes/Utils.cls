
public with sharing class Utils {
    public Utils() {
    }

    public static boolean validaAccountNumber(Account account){
        boolean validado = false;
        if(String.isEmpty(account.AccountNumber)){
            validado = true;
        }
        return validado;
    }

}