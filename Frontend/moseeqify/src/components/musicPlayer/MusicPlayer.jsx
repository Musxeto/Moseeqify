import React from "react";
import AudioPlayer from "react-h5-audio-player";
import "react-h5-audio-player/lib/styles.css";
import { useMusic } from "../../contexts/MusicContext";

const MusicPlayer = () => {
  const { currentSongUrl } = useMusic();

  return (
    currentSongUrl && (
      <div className="fixed bottom-0 left-0 right-0 bg-black text-white p-4">
        <AudioPlayer autoPlay src={currentSongUrl} />
      </div>
    )
  );
};

export default MusicPlayer;
