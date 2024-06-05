import React, { createContext, useContext, useState } from "react";

const MusicContext = createContext();

export const useMusic = () => useContext(MusicContext);

export const MusicProvider = ({ children }) => {
  const [currentSongUrl, setCurrentSongUrl] = useState(null);

  const handleSetCurrentSongUrl = (url) => {
    console.log("Setting current song URL:", url);

    setCurrentSongUrl(url);
  };

  return (
    <MusicContext.Provider
      value={{ currentSongUrl, setCurrentSongUrl: handleSetCurrentSongUrl }}
    >
      {children}
    </MusicContext.Provider>
  );
};
