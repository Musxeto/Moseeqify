import React from "react";
import AudioPlayer from "react-h5-audio-player";
import "react-h5-audio-player/lib/styles.css";

const MusicPlayer = ({ url }) => {
  return (
    <div className="fixed bottom-0 left-0 right-0 bg-black text-white p-4">
      <AudioPlayer
        autoPlay
        src={url}
        onPlay={() => console.log("onPlay")}
        // other props here
      />
    </div>
  );
};

export default MusicPlayer;
