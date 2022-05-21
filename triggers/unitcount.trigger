trigger unitcount on Order__c (after insert) {
    
   List<Order__c> odr = [select Quantity__c,Product__r.Units_Available__c from Order__c where id in :Trigger.new];
   
    List<Product__c> plist = new List<Product__c>();
    for(Order__c od: odr){
        if(od.Product__r.Units_Available__c >= od.Quantity__c){
            od.Product__r.Units_Available__c -= od.Quantity__c;
            plist.add(od.Product__r);
        }else{
            Order__c c = Trigger.newMap.get(od.id);        //Trigger.newMap.get(Order__c.id)
            c.addError('Out of Stock');
        }   
    }
    update plist;  
}