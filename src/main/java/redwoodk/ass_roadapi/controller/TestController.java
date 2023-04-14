package redwoodk.ass_roadapi.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {

    @GetMapping("/")
    public String home() {
        return "home";
    }

    @GetMapping("/jusoPopup")
    public String jusoPopup(){
        return "jusoPopup";
    }

    @PostMapping("/jusoPopup")
    public String jusoPopupResult(){
        return "jusoPopup";
    }
}
