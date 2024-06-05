import React from "react";
import { Link } from "react-router-dom";

const Album = ({ album }) => {
  return (
    <Link to={`/albums/${album.id}`} className="hover:no-underline">
      <div className="bg-gray-900 rounded-lg p-4">
        <img
          src={album.cover_image_link}
          alt={album.name}
          className="w-full h-auto rounded-lg mb-2"
        />
        <h2 className="text-lg font-bold text-white">{album.name}</h2>
        <p className="text-gray-400">{album.artist}</p>
      </div>
    </Link>
  );
};

export default Album;
