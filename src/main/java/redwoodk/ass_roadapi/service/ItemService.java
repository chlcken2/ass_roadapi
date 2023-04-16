package redwoodk.ass_roadapi.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import redwoodk.ass_roadapi.dao.mybatis.ItemMapper;
import redwoodk.ass_roadapi.dto.ItemResDto;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ItemService {

    private final ItemMapper itemMapper;

    public void saveItem(String roadFullAddr, HttpSession session) {
        LocalDateTime localDateTime = LocalDateTime.now();
        String sessionId = session.getId();
        itemMapper.save(roadFullAddr, sessionId, localDateTime);
    }

    public void deleteItem(Long teamId) {
        itemMapper.deleteItem(teamId);
    }

    public List<ItemResDto> getItems() {
        List<ItemResDto> items = itemMapper.getItems();
        return items;
    }
}
