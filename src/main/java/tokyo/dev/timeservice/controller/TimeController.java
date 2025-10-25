package tokyo.dev.timeservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Map;
import java.util.HashMap;

@RestController
public class TimeController {

    @GetMapping("/api/time")
    public Map<String, String> getCurrent() {
        ZoneId zoneId = ZoneId.of("Asia/Jakarta");
        LocalTime time = LocalTime.now(zoneId);
        LocalDate date = LocalDate.now(zoneId);

        Map<String, String> response = new HashMap<>();
        response.put("time", time.toString());
        response.put("date", date.toString());
        response.put("timezone", zoneId.toString());
        return response;
    }
}
