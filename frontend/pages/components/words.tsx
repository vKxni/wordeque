import { useState } from "react";

import Helmet from "react-helmet";
import styles from "./words.module.css";

import config from "../../backend.json";

function Words() {
    const [word, setWord] = useState("");
    const [words, setWords] = useState<string[]>();

    const handleData = (event: React.ChangeEvent<HTMLInputElement>) => {
        setWord(event.target.value);
    };

    function deleteContent() {
        setWord("");
        setWords([]);
    }

    const handleSubmit = async (e: React.SyntheticEvent) => {
        e.preventDefault();
        try {
            const url = `${config.BACKEND_URL}${word}`;
            const response = await fetch(url);
            const data = await response.json();

            if(!response.ok) {
                throw new Error(data.message);
            }

            setWords(data?.words);
        } catch (error) {
            console.log(error);
        }
    }
    return (
        <>
            <Helmet title="Wordeque • Search" defer={false} />
            <div className={styles.main}>
                <form onSubmit={handleSubmit}>
                    <input className={styles.input}
                        type="text"
                        id="message"
                        name="message"
                        onChange={handleData}
                        value={word}>
                    </input>
                </form>
                <div className={styles.buttons}>
                    <button onClick={handleSubmit}>Search</button>
                    <button onClick={deleteContent}>Delete</button>
                </div>
                <div className={styles.wordContainer}>
                    {words && typeof words === 'string' ? (
                        <p>{words}</p>
                    ) : words?.map((word, index) => (
                        <p key={index} className={styles.word}> {word} </p>
                    ))}
                </div>
            </div>
        </>
    );
}

export default Words;
