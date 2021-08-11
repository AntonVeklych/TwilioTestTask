trigger AccountTrigger on Account (before update) {

    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            HelperAccountTrigger.sendSMSIfGoldAccount(Trigger.new);
        }
    }
}