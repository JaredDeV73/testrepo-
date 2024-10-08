package com.example.service.interfaces;

import com.example.presentation.dto.UrlRequestDTO;
import com.example.presentation.dto.UrlResponseDTO;
import com.example.presentation.dto.UrlStatsDTO;

import java.util.ArrayList;
import java.util.List;

public interface URLShorteningService {

    // Crea una URL corta a partir de una URL original
    UrlResponseDTO createShortUrl(UrlRequestDTO urlRequestDTO);

    // Recupera la URL original a partir del código corto
    UrlResponseDTO getOriginalUrl(String shortCode);

    List<UrlResponseDTO> getAllUrls();

    // Elimina una URL corta existente
    void deleteShortUrl(String shortCode);

    // Obtiene las estadísticas de una URL corta (número de accesos)
    UrlStatsDTO getUrlStats(String shortCode);


}
