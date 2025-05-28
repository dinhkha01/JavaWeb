package dk.model.dao;

import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;

@Repository
public class ProductRepository {
    public List<String> getAll(){
        List<String> list = Arrays.asList("p1ppp","p2aaaa","p3c","p4d","p5eeee");
        return list;
    }
}
