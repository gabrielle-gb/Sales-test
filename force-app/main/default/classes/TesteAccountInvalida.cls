@isTest
public class TesteAccountInvalida {
    @isTest
    static void meuBatch() {
        LimpaAccountInvalida meuBatch = new LimpaAccountInvalida();
        Id batchInstanceId = Database.executeBatch(meuBatch);
    }
}