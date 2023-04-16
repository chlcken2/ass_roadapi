package redwoodk.ass_roadapi.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import redwoodk.ass_roadapi.dto.ItemResDto;
import redwoodk.ass_roadapi.service.ItemService;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ItemController {

    private final ItemService itemService;

    @GetMapping("/")
    public String home( ) {
        return "home";
    }

    @GetMapping("/jusoPopup")
    public String jusoPopup() {
        return "jusoPopup";
    }

    @PostMapping("/jusoPopup")
    public String jusoPopupResult() {
        return "jusoPopup";
    }

    @PostMapping("/item/save")
    public String saveItem(@RequestParam String roadFullAddr, HttpSession session) {
        itemService.saveItem(roadFullAddr, session);
        return "home";
    }

    @DeleteMapping("/items/{teamId}")
    public String deleteItem(@PathVariable Long teamId) {
        itemService.deleteItem(teamId);
        return "home";
    }

    @GetMapping("/items")
    @ResponseBody
    public List<ItemResDto> getItems( ) {
        List<ItemResDto> items = itemService.getItems();
        log.info("items" + items);
        log.info("000000000000000");
        return items;
    }
}
