import type { Metadata } from "next";
import "./globals.css";

// primreact
import { PrimeReactProvider } from "primereact/api";
import "primereact/resources/themes/lara-light-blue/theme.css";
import 'primeicons/primeicons.css';

import SideBar from "./component/sideBar";

export const metadata: Metadata = {
    title: "Port Database Management",
    description: "Generated by create next app",
};

export default async function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return (
        <html lang="en">
            <PrimeReactProvider>
                <head>
                    <script
                        dangerouslySetInnerHTML={{
                            __html: `
                            const style = document.createElement('style')
                            style.innerHTML = '@layer tailwind-base, primereact, tailwind-utilities;'
                            style.setAttribute('type', 'text/css')
                            document.querySelector('head').prepend(style)
                            `,
                        }}
                    />
                </head>
                <body className="flex flex-row">
                    <div className="basis-1/5 w-64 h-screen">
                        <SideBar />
                    </div>
                    <div className="basis-4/5 ">
                        {children}
                    </div>
                </body>
            </PrimeReactProvider>
        </html>
    );
}
