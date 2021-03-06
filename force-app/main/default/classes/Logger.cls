public class Logger {
    private static List<Log__c> logs = new List<Log__c>();

    public static void log(Logger.LogSeverity severity, String message) {
        Log__c log = new Log__c();
        log.Severity__c = severity.name();
        log.Message__c = message;
        log.Logged_at__c = DateTime.now();
        logs.add(log);
    }

    public static void logInfo(String message) {
        log(Logger.LogSeverity.INFO, message);
    }

    public static void logSuccess(String message) {
        log(Logger.LogSeverity.SUCCESS, message);
    }

    public static void logError(String message) {
        log(Logger.LogSeverity.ERROR, message);
    }

    public static void commitLogs() {
            insert logs;
    }

    public enum LogSeverity {
        DEBUG,
        INFO,
        SUCCESS,
        ERROR
    }
}