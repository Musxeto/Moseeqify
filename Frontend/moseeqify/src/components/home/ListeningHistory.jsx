import React, { useEffect, useState } from "react";
import { useUser } from "../../contexts/UserContext";

const ListeningHistory = () => {
  const { user } = useUser();
  const [history, setHistory] = useState([]);

  useEffect(() => {
    const fetchHistory = async () => {
      try {
        const response = await fetch(
          `http://localhost:5000/users/${user.username}/listening-history`
        );
        if (response.ok) {
          const data = await response.json();
          setHistory(data);
        } else {
          console.error("Failed to fetch listening history.");
        }
      } catch (error) {
        console.error("Error fetching listening history:", error);
      }
    };

    if (user) {
      fetchHistory();
    }
  }, [user]);

  return (
    <div className=" h-80 border-2 border-red-500 bg-red-400 text-white p-8 shadow-lg overflow-y-auto">
      <div>
        <h2 className="text-xl font-bold mb-4">Listening History</h2>
        {history.length > 0 ? (
          <ul>
            {history.map((item) => (
              <li key={item.id} className="mb-2">
                {item.title} - {item.artist}
              </li>
            ))}
          </ul>
        ) : (
          <p>No listening history available.</p>
        )}
      </div>
    </div>
  );
};

export default ListeningHistory;
