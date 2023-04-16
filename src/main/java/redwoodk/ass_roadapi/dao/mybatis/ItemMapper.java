package redwoodk.ass_roadapi.dao.mybatis;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import redwoodk.ass_roadapi.dto.ItemResDto;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ItemMapper {
    void save(@Param("roadFullAddr") String roadFullAddr, @Param("sessionId") String sessionId, @Param("createdDate") LocalDateTime createdDate);

    List<ItemResDto> getItems();

    void deleteItem(Long teamId);
}
